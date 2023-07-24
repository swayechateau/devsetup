use std::env;

fn main() {
    // Fetch the command line arguments
    let args: Vec<String> = env::args().collect();

    // Check if optional arguments were provided
    if args.len() > 1 {
        // Process the optional arguments
        for arg in &args[1..] {
            match arg.as_str() {
                "-a" => {
                    // Handle the "-a" flag
                    println!("Option -a is provided, installing everyrthing!");
                    break;
                }
                "-b" => {
                    // Handle the "-b" flag
                    println!("Option -b is provided, for the brave souls, wanting only the core dev tools!");
                    break;
                }
                "-c" => {
                    // Handle the "-c" flag
                    println!("Option -c is provided.. I see, you wish for something custom!");
                }
                _ => {
                    // Handle any other unrecognized options
                    println!("Unrecognized option: {}, you think we wouldn't know", arg);
                }
            }
        }
    } else {
        // No optional arguments provided
        println!("No optional arguments provided.");
    }
}
