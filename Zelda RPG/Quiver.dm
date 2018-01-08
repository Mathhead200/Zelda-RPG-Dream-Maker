
obj/Quiver
	icon = 'Quiver.dmi'
	var
		size

	proc
		getArrow()
			for( var/obj/Arrow/a in src.contents )
				src.contents.Remove(a)
				return a
			return null

		addArrows(x)
			for( var/i = 0, i < x, i++ )
				new/obj/Arrow( src.contents )

	New(size, isFull = 1)
		src.size = size
		if(isFull)
			for( var/i = 0, i < size, i++ )
				src.contents.Add( new/obj/Arrow() )