/// @description Insert description here
// You can write your code in this editor
creator = oPlayer.id;
dmg = 0;

if oSword.swingSprite {
	sprite_index = sSwing;
	oSword.swingSprite = !oSword.swingSprite;
} else {
	sprite_index = sSwingInverse;
	oSword.swingSprite = !oSword.swingSprite;
}

if oPlayer.ledgeSwing {
	sprite_index = sSwingLedge;
}