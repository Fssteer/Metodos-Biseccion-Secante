import reflex as rx
config = rx.Config(
    app_name="fronted",
    api_url="https://secante-biseccion.servidor507.site",
    plugins=[
        rx.plugins.SitemapPlugin(),
        rx.plugins.TailwindV4Plugin(),
    ],
)
