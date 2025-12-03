use color_eyre::Report;
{%- if use_init %}

mod init;
{%- endif %}
{%- if use_mimalloc %}

// Avoid musl's default allocator due to lackluster performance
// https://nickb.dev/blog/default-musl-allocator-considered-harmful-to-performance
#[cfg(target_env = "musl")]
#[global_allocator]
static GLOBAL: mimalloc::MiMalloc = mimalloc::MiMalloc;
{%- endif %}

#[tracing::instrument]
fn main() -> Result<(), Report> {
{%- if use_init %}
    init::initialize()?;
{% endif %}
    println!("Hello, world!");

    Ok(())
}
