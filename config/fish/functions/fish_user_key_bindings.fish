function fish_user_key_bindings
	for mode in insert default visual
		bind -M $mode \cf forward-char
		bind -M $mode -m insert \cd exit
	end
	bind -M default :q execute
	bind -M default :wq execute
end

