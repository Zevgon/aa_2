class Employee
	attr_reader :name, :title, :salary
	attr_accessor :boss
	def initialize(name, title, salary, boss = nil)
		@name = name
		@title = title
		@salary = salary
		@boss = boss
		add_self_to_boss_employees if boss
	end

	def add_self_to_boss_employees
		@boss.employees << self
	end

	def bonus(multiplier)
		@salary * multiplier
	end
end
