use color_eyre::Report;
{%- if use_init %}

mod init;
{%- endif %}

#[tracing::instrument]
fn main() -> Result<(), Report> {
    {%- if use_init %}
    init::initialize()?;
    {% endif %}
    println!("Hello, world!");

    Ok(())
}
