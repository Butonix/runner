use iron::prelude::*;
use iron::status;
use rss::{Channel};

use common::lazy_static::{CONFIG_TABLE};
use services::topic::get_rss_topic_list;

pub fn render_rss(req: &mut Request) -> IronResult<Response> {

    let items = get_rss_topic_list();
    let base_path = CONFIG_TABLE.get("path").unwrap().as_str().unwrap();

    let channel = Channel {
        title: "Rust社区".to_owned(),
        description: "Rust社区最新话题".to_owned(),
        link: base_path.to_owned(),
        items: items,
        language: Some("zh-cn".to_owned()),
        ..Default::default()
    };

    let mut res = Response::new();

    res.set_mut(status::Ok)
        .set_mut(mime!(Application/Xml))
        .set_mut(channel.to_string());

    Ok(res)
}