use std::io::{self, BufRead};

/// Checks if a given phone is an Android phone with Google services enabled
/// and returns a boolean value indicating whether there are games on the phone or not.
///
/// # Arguments
///
/// * `phone` - The type of phone (e.g., "android", "iphone").
/// * `google` - Indicates whether the phone has Google services enabled or not.
///
/// # Returns
///
/// Returns a boolean value indicating whether there are games on the phone or not.
fn games_on_your_phone(phone: &str, google: bool) -> bool {
    let games = phone == "android" && google;
    if games {
        println!("GAMES ON PHONE :))))))))");
    } else {
        println!("NO GAMES ON PHONE :(((((((((");
    }
    games
}

fn main() {
    println!("What's your phone os?");
    let phone = read_input().expect("Can't read from stdin");

    println!("Does it have google?, y/n");
    let google = read_input()
        .expect("Can't read from stdin")
        .to_lowercase()
        .trim()
        .to_string();

    let google_status = google == "y" || google == "yes";
    let result = games_on_your_phone(phone.trim(), google_status);

    if result {
        println!("gaming");
    } else {
        println!(":(");
    }
}

fn read_input() -> io::Result<String> {
    let stdin = io::stdin();
    let mut stdin = stdin.lock();
    let mut input = String::new();
    stdin.read_line(&mut input)?;
    Ok(input)
}
