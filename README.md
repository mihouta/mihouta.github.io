# mihouta 的博客

使用 Astro 与 AstroPaper 构建，并通过 GitHub Actions 发布到 GitHub Pages。

## 本地开发

```sh
pnpm install
pnpm dev
```

## 发布文章

在 `src/content/posts/` 中新增 Markdown 或 MDX 文件，然后提交并推送到 `main` 分支。部署工作流会自动构建并发布网站。

主题来源：[AstroPaper](https://github.com/satnaing/astro-paper)。
