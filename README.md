# mihouta 的博客

使用 Astro 与 AstroPaper 构建，并通过 GitHub Actions 发布到 GitHub Pages。

## 本地开发

```sh
pnpm install
pnpm dev
```

## 发布文章

在 `src/content/posts/` 中新增 Markdown 或 MDX 文件，然后提交并推送到 `main` 分支。部署工作流会自动构建并发布网站。

## Google Analytics

网站支持可选的 Google Analytics 4（GA4）访问统计。未配置统计 ID 时不会加载 Google Analytics；本地开发模式也不会发送统计数据。

1. 在 Google Analytics 中创建 GA4 媒体资源和 Web 数据流，网站网址填写 `https://mihouta.github.io/`。
2. 复制 Web 数据流的衡量 ID（格式为 `G-XXXXXXXXXX`）。
3. 打开 GitHub 仓库的 **Settings → Secrets and variables → Actions → Variables**，新建仓库变量：
   - Name：`PUBLIC_GOOGLE_ANALYTICS_ID`
   - Value：上一步复制的衡量 ID
4. 重新运行 **Deploy to GitHub Pages** 工作流，或向 `main` 分支推送一次提交。
5. 在 GA4 Web 数据流的增强型衡量设置中，确认 **网页浏览 → 根据浏览器历史记录事件更改网页** 已启用，以统计站内无刷新跳转。

部署后可在 Google Analytics 的 **报告 → 实时** 中验证访问。标准报告通常需要更长时间才会完整显示。

如需在本地生产构建中验证，可复制 `.env.example` 为 `.env`，填写衡量 ID后运行 `pnpm build && pnpm preview`。不要提交 `.env` 文件。

主题来源：[AstroPaper](https://github.com/satnaing/astro-paper)。
