def include(char, arr):
	for str_char in arr:
		if str_char == char:
			return True
	return False


def anagrams_phase1(str1, str2):
	str2_arr = list(str2)
	perms = itertools.permutations(list(str1))
	for perm in perms:
		if list(perm) == str2_arr:
			return True

	return False

def anagrams_phase2(str1, str2):
	arr1 = list(str1)
	arr2 = list(str2)
	idx = 0
	while idx < len(arr1):
		char = arr1[idx]
		if include(char, arr2):
			arr2_idx = arr2.index(char)
			del(arr2[arr2_idx])
			del(arr1[idx])
			idx -= 1
		idx += 1
	return arr1 == arr2

def anagrams_phase3(str1, str2):
	arr1 = list(str1)
	arr2 = list(str2)
	arr1.sort()
	arr2.sort()
	return arr1 == arr2

def anagrams_phase4(str1, str2):
	dictionary = defaultdict(int)
	for char in str1:
		dictionary[char] += 1
	for char in str2:
		dictionary[char] -= 1
		if dictionary[char] == 0:
			del(dictionary[char])
	return not dictionary
