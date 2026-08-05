import rss from "@astrojs/rss";
import { getCollection } from "astro:content";
import { getSortedPosts } from "@/utils/getSortedPosts";
import { getPostUrl } from "@/utils/getPostPaths";
import config from "@/config";

function makeUrlsAbsolute(html: string, base: URL) {
  return html.replace(
    /\b(href|src)="([^"#][^"]*|#[^"]*)"/g,
    (match, attribute: string, value: string) => {
      try {
        return `${attribute}="${new URL(value, base).href}"`;
      } catch {
        return match;
      }
    }
  );
}

export async function GET() {
  const posts = await getCollection("posts");
  const sortedPosts = getSortedPosts(posts);

  return rss({
    title: config.site.title,
    description: config.site.description,
    site: config.site.url,
    items: sortedPosts.map(({ data, id, filePath, rendered }) => {
      const postUrl = new URL(
        getPostUrl(id, filePath, config.site.lang),
        config.site.url
      );

      return {
        link: postUrl.href,
        title: data.title,
        description: data.description,
        content: makeUrlsAbsolute(rendered?.html ?? data.description, postUrl),
        pubDate: new Date(data.modDatetime ?? data.pubDatetime),
        categories: data.tags,
      };
    }),
  });
}
