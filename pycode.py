# a = {}
# a[1] = 10
# a[2] = 3
# for k, v in a.items():
#     print(k)



# Longest Palendrome
# https://leetcode.com/problems/longest-palindromic-substring/submissions/

def palendrome(s):
    def find_two_or_three(s):
        ans = {}
        # Gets len of 2
        for i in range(0, len(s)-1):
            j = i + 1
            if s[i] == s[j] and j <= len(s):
                print(s[i] + s[j])
                ans[i] = s[i] + s[j]

        # now get length of 3
        for i in range(0, len(s) -2):
            k = i + 2
            if s[i] == s[k] and k <= len(s):
                ans[i] = s[i] + s[i+1] + s[k]
        return ans

    # now I can find the index of two or three, i
    # i can run this function at the indices
    # at the index, if length(a) % 2 == 0 - check left and right
    # my first function will return all bases (2 or 3)
    # my second function will increase those on either side
    # check to make sure index is in the range
    # if expanded is a string add it to the answer (plus index)
    # remove the lower one
    def expand(s, ans):
        expanded = {}
        for i, v in ans.items():
            print(i)
            # if i == 0 and len(v) + 2 <= len(s):
            #     if s[i] == s[len(v) + 2]:
            #         print('a', i, v)
            #         expanded[i] = s[i:(len(v)+2) + 1]

            if i - 1 >= 0 and len(v) + 1 <= len(s):
                if s[i-1] == s[len(v) + 1]:
                    print('b', i, v)
                    expanded[i] = s[i-1:(len(v)+1) + 1]
        return expanded

    # step 3: keep running expand until it returns nothing
    s = 'abababababababa'
    ans = find_two_or_three(s)
    ans2 = expand(s, ans)
    if len(ans2) > 0:
        keep_going = True
        while keep_going:
            new = expand(s, ans2)
            if len(new) > 0:
                ans2 = new.copy()
            else:
                keep_going = False
    else:
        return ans
    
    # step 4: get the longets palendrome
    return ans2
    
    # cycle through ans to get longest
    # max_len = 0
    # for i, a in enumerate(ans):
    #     print(a)
    #     if len(a) > max_len:
    #         out = a
    #         max_len = len(a) 
    # return ans

palendrome('abab')
palendrome('abbab')

