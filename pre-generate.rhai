// we can see existing variables.
// note that template and Rhai variables are separate!
let crate_type = variable::get("crate_type");
// debug(`crate_type: ${crate_type}`);

// Enable `mimalloc` by default
variable::set("use_mimalloc", true);

let license = variable::get("license").to_upper();
while (
    switch license {
        "None" => {
            file::delete("LICENSE-MIT");
            file::delete("LICENSE-APACHE");
            false // Output for while block
        }
        "APACHE" => {
            file::delete("LICENSE-MIT");
            file::rename("LICENSE-APACHE", "LICENSE");
            false // Output for while block
        }
        "MIT" => {
            file::delete("LICENSE-APACHE");
            file::rename("LICENSE-MIT", "LICENSE");
            false  // Output for while block
        }
        "Both" => false,  // Output for while block
        _ => true,  // Output for while block
        }
) {
    license = variable::prompt("What license to use?", "MIT", [
        "None",
        "APACHE",
        "MIT",
        "Both",
    ]);
};

// Delete the obsolete .cargo/config file.
// Was used for forcing sparse cargo registry
file::delete(".cargo");

if !variable::prompt("Add '.devcontainer' files?", true) {
    file::delete(".devcontainer");
}

let use_init = variable::prompt("Add initialization files?", true);
variable::set("use_init", use_init);

if (use_init) {
    variable::set("use_clap", variable::prompt("Add argument parser (using 'clap' crate)?", true));
    // variable::set("use_console_log", variable::prompt("Add console logging to stderr?", true));
} else {
    file::delete("src/init.rs");
}
