require 'tdd'

describe 'my_uniq' do
	let(:array) { [1, 4, 6, 4, 4, 2, 3, 6] }
	let(:uniq_array) { my_uniq(array) }
	it 'removes duplicates' do
		uniq_array.each do |el|
			expect(uniq_array.count(el)).to eq(1)
		end
	end

	it 'only contains items from the original array' do
		uniq_array.each do |el|
			expect(array).to include(el)
		end
	end

	it 'does not modify the original array' do
		expect { my_uniq(array) }.not_to change { array }
	end
end

describe 'two_sum' do
	let (:array) { [1, 5, 7, 2] }
	let (:target) { 9 }
	it 'checks whether two items in the array sum to the target' do
		expect(two_sum(array, target)).to be(true)
	end
	let (:array2) { [1, 2, 5] }
	let (:target2) { 4 }
	it 'doesn\'t find false positives by adding the same number to itself' do
		expect(two_sum(array2, target2)).to be(false)
	end
end

describe 'my_transpose' do
	let (:array) {[
			[1, 2, 3],
			[4, 5, 6],
			[7, 8, 9]
		]}
	let (:transposed) {array.transpose}
	it 'transposes the array' do
		expect(my_transpose(array)).to eq(transposed)
	end

	let (:array2) {[
		[1, 2, 3, 4],
		[5, 6, 7, 8]
		]}
	it 'can handle rectangles just fine' do
		expect{my_transpose(array2)}.not_to raise_error
	end
end
