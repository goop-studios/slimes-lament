use anyhow::Result;
use bevy::prelude::*;

mod components;
use components::movement::{movement, Player};

fn setup(mut commands: Commands, asset_server: Res<AssetServer>) {
    commands.spawn(Camera2dBundle::default());
    commands.spawn((
        SpriteBundle {
            texture: asset_server.load("sprites/static/gum.png"),
            transform: Transform::from_xyz(32., 0., 0.),
            ..default()
        },
        Player,
    ));
}

fn main() -> Result<()> {
    App::new()
        .add_plugins(DefaultPlugins)
        .insert_resource(FixedTime::new_from_secs(1.0 / 60.0))
        .add_systems(Startup, setup)
        .add_systems(Update, (movement, bevy::window::close_on_esc))
        .run();
    Ok(())
}
