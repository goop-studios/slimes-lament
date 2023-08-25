use anyhow::Result;
use bevy::prelude::*;

#[derive(Component)]
struct Person;

#[derive(Component)]
struct Name(String);

fn add_people(mut commands: Commands) {
    commands.spawn((Person, Name("Elaina Proctor".to_string())));
    commands.spawn((Person, Name("Renzo Hume".to_string())));
    commands.spawn((Person, Name("Zayna Nieves".to_string())));
}

fn hello_world() {
    println!("Hello, World!");
}

fn greet_people(query: Query<&Name, With<Person>>) {
    for name in &query {
        println!("Hello, {}!", name.0);
    }
}

fn main() -> Result<()> {
    App::new()
        .add_systems(Startup, add_people)
        .add_systems(Update, (hello_world, greet_people))
        .run();
    Ok(())
}
