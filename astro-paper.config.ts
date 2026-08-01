import { defineAstroPaperConfig } from "./src/types/config";

export default defineAstroPaperConfig({
  site: {
    url: "https://mihouta.github.io/",
    title: "行舟知水",
    description: "记录技术、学习与生活。",
    author: "mihouta",
    profile: "https://github.com/mihouta",
    ogImage: "og.png",
    lang: "zh-cn",
    timezone: "Asia/Shanghai",
    dir: "ltr",
  },
  posts: {
    perPage: 4,
    perIndex: 5,
    scheduledPostMargin: 15 * 60 * 1000,
  },
  features: {
    lightAndDarkMode: true,
    dynamicOgImage: true,
    showArchives: true,
    showBackButton: true,
    editPost: {
      enabled: true,
      url: "https://github.com/mihouta/mihouta.github.io/edit/main/",
    },
    search: "pagefind",
  },
  socials: [
    { name: "github", url: "https://github.com/mihouta" },
  ],
  shareLinks: [
    { name: "whatsapp", url: "https://wa.me/?text=" },
    { name: "facebook", url: "https://www.facebook.com/sharer.php?u=" },
    { name: "x",        url: "https://x.com/intent/post?url=" },
    { name: "telegram", url: "https://t.me/share/url?url=" },
    { name: "pinterest", url: "https://pinterest.com/pin/create/button/?url=" },
    { name: "mail",     url: "mailto:?subject=See%20this%20post&body=" },
  ],
});
