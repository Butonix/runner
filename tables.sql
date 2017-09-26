DROP TABLE IF EXISTS favorite;
DROP TABLE IF EXISTS article_vote;
DROP TABLE IF EXISTS comment_vote;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS github_user;
DROP TABLE IF EXISTS user;

# 用户表
CREATE TABLE user (
    id int(16) PRIMARY KEY AUTO_INCREMENT NOT NULL,  -- 用户id
    username varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,  -- 用户账号
    nickname varchar(32) COLLATE utf8mb4_unicode_ci,  -- 用户昵称
    user_role int(1) DEFAULT 1,  -- 0-禁言用户, 1-普通用户, 2-管理员
    register_source tinyint(2) unsigned DEFAULT 0,  -- 注册来源，0-本站注册, 1-github
    gender int(1) DEFAULT 1,  -- 0-female, 1-male
    signature mediumtext COLLATE utf8mb4_unicode_ci,  -- 用户签名
    email varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,  -- 邮箱
    email_bind_time datetime,  -- 邮箱绑定时间
    avatar_url varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,  -- 头像地址
    qq varchar(32) COLLATE utf8mb4_unicode_ci,  -- qq号码
    location varchar(32) COLLATE utf8mb4_unicode_ci,  -- 地址
    site varchar(32) COLLATE utf8mb4_unicode_ci,  -- 用户个人网站
    github_account varchar(32) COLLATE utf8mb4_unicode_ci,  -- 用户github账号
    password varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,  -- 密码
    salt varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,  -- 密码加盐
    create_time datetime NOT NULL,  -- 用户创建时间
    update_time datetime,  -- 用户更新时间
    UNIQUE KEY username (username),
    UNIQUE KEY email (email)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# github用户表
CREATE TABLE github_user (
    id int(32) PRIMARY KEY NOT NULL,  -- github id
    user_id int(16) NOT NULL,  -- 本站id
    username varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,  -- github用户名
    nickname varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,  -- github昵称
    email varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,  -- github邮箱
    avatar_url varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,  -- github头像地址
    home_url varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,  -- github用户主页地址
    create_time datetime NOT NULL,  -- 绑定时间
    update_time datetime,  -- 更新绑定时间
    KEY user_id (user_id),
    CONSTRAINT github_user_ibfK_1 FOREIGN KEY (user_id) REFERENCES user (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# 文章表
CREATE TABLE article (
    id int(32) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id int(16) NOT NULL,
    category varchar(16) NOT NULL,
    title varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
    content mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
    status varchar(8) NOT NULL,
    priority tinyint(4) DEFAULT 0,
    comment_count int(16) DEFAULT 0,
    create_time datetime NOT NULL,
    update_time datetime NOT NULL,
    view_count int(32) DEFAULT 0,
    KEY user_id (user_id),
    CONSTRAINT article_ibfk_1 FOREIGN KEY (user_id) REFERENCES user (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# 评论表
CREATE TABLE comment (
    id int(64) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    article_id int(32) NOT NULL,
    user_id int(16) NOT NULL,
    content mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
    create_time datetime NOT NULL,
    KEY article_id (article_id),
    KEY user_id (user_id),
    CONSTRAINT comment_ibfk_1 FOREIGN KEY (article_id) REFERENCES article (id),
    CONSTRAINT comment_ibfk_2 FOREIGN KEY (user_id) REFERENCES user (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# 消息表
CREATE TABLE message (
    id int(64) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    article_id int(32) NOT NULL,
    comment_id int(64) NOT NULL,
    from_user_id int(16) NOT NULL,
    to_user_id int(16) NOT NULL,
    content mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
    create_time datetime NOT NULL,
    status varchar(8) NOT NULL,
    KEY article_id (article_id),
    KEY comment_id (comment_id),
    KEY from_user_id (from_user_id),
    KEY to_user_id (to_user_id),
    CONSTRAINT message_ibfk_1 FOREIGN KEY (article_id) REFERENCES article (id),
    CONSTRAINT message_ibfk_2 FOREIGN KEY (comment_id) REFERENCES comment (id),
    CONSTRAINT message_ibfk_3 FOREIGN KEY (from_user_id) REFERENCES user (id),
    CONSTRAINT message_ibfk_4 FOREIGN KEY (to_user_id) REFERENCES user (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# 文章点赞表
CREATE TABLE article_vote (
    id int(64) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id int(16) NOT NULL,
    article_id int(32) NOT NULL
) ENGINE = InnoDB;

# 评论点赞表
CREATE TABLE comment_vote (
    id int(64) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id int(16) NOT NULL,
    comment_id int(32) NOT NULL
) ENGINE = InnoDB;

# 文章收藏表
CREATE TABLE favorite (
    id int(64) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id int(16) NOT NULL,
    article_id int(32) NOT NULL
) ENGINE = InnoDB;



