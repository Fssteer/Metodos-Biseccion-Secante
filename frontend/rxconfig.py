import reflex as rx

config = rx.Config(
    app_name="fronted",
    api_url="http://localhost:8001",
    plugins=[
        rx.plugins.SitemapPlugin(),
        rx.plugins.TailwindV4Plugin(),
    ],
)
