//EARTH DEFENSE FORCE 4.1 The Shadow of New Despair Autosplitter v2 final
//Special thanks to Souzooka who made the EDF5 script from which was a lot of help in making that script

state("EDF41", "Steam 07/09/16 update")
{
	uint TotalResourcesCount : "EDF41.exe", 0x00CC84C8, 0x70;
	uint LoadedResourcesCount : "EDF41.exe", 0x00CC84C8, 0x38, 0x10;
	short MissionActive : "EDF41.exe", 0x00CC84E8, 0x28, 0x230;
	// prevent splits on gameoverevent, also only set to > 0 when you have control of the character
	float PlayerCurrentArmor : "EDF41.exe", 0x00CC84E8, 0x28, 0x130, 0x8, 0x16C;
}

startup
{
	settings.Add("test", true, "Start the timer when the player has control.");
	settings.Add("splits", true, "Split at end of missions.");
}

isLoading
{
	return current.TotalResourcesCount != current.LoadedResourcesCount;
}

split
{
	if (settings["splits"])
	{
		return old.MissionActive > current.MissionActive && current.PlayerCurrentArmor > 0;
	}

	return false;
}

start
{
	if (settings["test"])
	{
		return current.PlayerCurrentArmor > 0;
	}

	return false;
}
