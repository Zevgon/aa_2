require_relative 'Employee'

class Manager < Employee
	attr_accessor :employees
	def initialize(name, title, salary, boss = nil, employees = [])
		@employees = employees
		super(name, title, salary, boss)
	end

	def bonus(multiplier)
		total = 0
		@employees.each do |employee|
			if employee.is_a?(Manager)
				total += employee.sum_of_employee_salaries
				total += employee.salary
			else
				total += employee.salary
			end
		end

		total * multiplier
	end

	def sum_of_employee_salaries
		sum = 0
		@employees.each do |employee|
			sum += employee.salary
		end

		sum
	end
end

ned = Manager.new('Ned', 'Founder', 1000000)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
shawna = Employee.new('Shawna', 'TA', 12000, darren)
david = Employee.new('David', 'TA', 10000, darren)

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
