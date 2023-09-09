use bevy::prelude::*;
use tracing::info;

#[derive(Component)]
pub struct Player;

pub fn movement(
    keyboard_input: Res<Input<KeyCode>>,
    mut query: Query<&mut Transform, With<Player>>,
    time_step: Res<FixedTime>,
) {
    let speed = 2.0;
    let mut player_transform = query.single_mut();
    let mut movement: (f32, f32) = (0.0, 0.0);

    if keyboard_input.pressed(KeyCode::W) | keyboard_input.pressed(KeyCode::Up) {
        info!("Up");
        movement.1 += 1.0;
    }
    if keyboard_input.pressed(KeyCode::S) | keyboard_input.pressed(KeyCode::Down) {
        info!("Down");
        movement.1 -= 1.0;
    }
    if keyboard_input.pressed(KeyCode::A) | keyboard_input.pressed(KeyCode::Left) {
        info!("Left");
        movement.0 += 1.0;
    }
    if keyboard_input.pressed(KeyCode::D) | keyboard_input.pressed(KeyCode::Right) {
        info!("Right");
        movement.0 += 1.0;
    }

    let (new_pos_x, new_pos_y) = (
        player_transform.translation.x * movement.0 * speed * time_step.period.as_secs_f32(),
        player_transform.translation.y * movement.1 * speed * time_step.period.as_secs_f32(),
    );
    (
        player_transform.translation.x,
        player_transform.translation.y,
    ) = (new_pos_x, new_pos_y)
}
