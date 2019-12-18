state("EDF41", "Steam 07/09/16 update")
{
	uint TotalResourcesCount : "EDF41.exe", 0x00CC84C8, 0x70;
	uint LoadedResourcesCount : "EDF41.exe", 0x00CC84C8, 0x38, 0x10;
	//There's several million pointers for that specific address, I don't know why and I don't care because it works and does what I want it to do, I'm not even sure what it's actually supposed to do
	bool MysteryValue : "EDF41.exe", 0x00C87930, 0x84;
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
		return old.MysteryValue && !current.MysteryValue && current.PlayerCurrentArmor > 0;
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