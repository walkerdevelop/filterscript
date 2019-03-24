#include a_samp

forward CheckPlayer(playerid);

new PlayerHeart[MAX_PLAYERS];

public OnPlayerConnect(playerid) {
	return SendClientMessage(playerid, -1, "Author: vk.com/walkerscript (#Walker)");
}
public OnPlayerDisconnect(playerid, reason) {
	if(GetPVarInt(playerid, "Heart") == 1) DestroyObject(PlayerHeart[playerid]);
	SetPVarInt(playerid, "Heart", 0);
	return SendClientMessage(playerid, -1, "I love minecraft!");
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) {
	//if(issuerid == INVALID_PLAYER_ID) return 0;
	if(GetPVarInt(playerid, "Heart") == 1) return 0;
	SetTimerEx("CheckPlayer", 300, false, "i", playerid);
	return 1;
}
public CheckPlayer(playerid) {
	if(GetPVarInt(playerid, "Heart") == 1) return 0;
	new Float:health;
	GetPlayerHealth(playerid, health);
	if(health >= 5) return CreateObjectAtHead(playerid, 1240);
	return 0;
}
public OnPlayerDeath(playerid, killerid, reason) {
	if(GetPVarInt(playerid, "Heart") == 1) DestroyHeart(playerid);
	return CreateObjectAtHead(playerid, 1254);
}
stock CreateObjectAtHead(playerid, obj) {
	PlayerHeart[playerid] = CreateObject(obj, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	SetPVarInt(playerid, "Heart", 1);
	AttachObjectToPlayer(PlayerHeart[playerid], playerid, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0);
	return SetTimerEx("DestroyHeart", 1000*2, false, "i", playerid);
}
forward DestroyHeart(playerid);
public DestroyHeart(playerid) {
	DestroyObject(PlayerHeart[playerid]);
	SetPVarInt(playerid, "Heart", 0);
	return 1;
}
