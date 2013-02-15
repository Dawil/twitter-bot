Sequel.migration do
	change do
		add_column :users, :score, Integer
	end
end
