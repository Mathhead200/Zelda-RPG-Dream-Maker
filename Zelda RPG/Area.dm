
area
	var
		music = null
		volume = 100

	Entered(atom/movable/o, atom/oldLoc)
		if( music != null )
			o << sound(music, 1, 0, 1, volume)

	Overworld
		HyruleField
			music = 'Hyrule Field.midi'
			volume = 20

		LayhamMountain
			music = 'Layham Mountain.midi'

		CastleOutside
			music = 'Outside the Castle.midi'
			volume = 30

		Island
			music = 'Island.midi'
			volume = 30

		MinesOutside
			music = 'Outside the Mines.midi'
			volume = 30

		DarkForest
			music = 'Dark Forest.midi'
			icon = 'Weather.dmi'
			icon_state = "Dark"
			layer = MOB_LAYER+1

		FurnCity
			music = 'Furn City.midi'
			volume = 30

		FurnRuins
			music = 'Furn Ruins.midi'
			volume = 30

		Graveyard
			music = 'Graveyard.midi'
			icon = 'Weather.dmi'
			icon_state = "Black"
			layer = MOB_LAYER+1
			volume = 30

		MuckMarsh
			music = 'Muck Marsh.midi'
			icon = 'Weather.dmi'
			icon_state = "Rain"
			layer = MOB_LAYER+1

	BossThemes
		BossBattle
			music = 'Boss Theme.midi'
			volume = 15

		FaisMinion
			music = 'Fais Minion Theme.midi'

		FaisBattle
			music = 'Fais Theme.midi'
			volume = 15

	Dungeon
		LayhamMines
			music = 'Level 1 Layham Mines.midi'

		ToxicWoods
			music = 'Level 2 Toxic Woods.midi'
			volume = 30

		LavaPits
			music = 'Level 3 Lava Pits.midi'
			volume = 30

		ChickwasCave
			music = 'Level 4 Chickwas Cave.midi'

		DampRuins
			music = 'Level 5 Damp Ruins.midi'

		SecretTomb
			music = 'Level 6 Secret Tomb.midi'
			volume = 30

		CharedVale
			music = 'Level 7 Chared Vale.midi'
			volume = 30

		IcedTower
			music = 'Level 8 Iced Tower.midi'
			volume = 30

		FaisCastle
			music = 'Level 9 Fais Castle.midi'
			volume = 30

	Misc
		House
			music = 'A House.midi'
			volume = 30

		Cave
			music = 'A Cave.midi'
			volume = 30

		Store
			music = 'A Store.midi'

		Pirates
			music = 'Pirate\'s Ship.midi'
			volume = 30

		Relic_Rooms
			music = 'Relic Room.midi'
			volume = 30

