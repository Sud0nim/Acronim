# Acronim
Some simple procs for messing around with words.

These are especially useless for real-life use, but were a fun way to learn more about Nim.

# Examples

Iterate through all possible combinations of the letters in a word:

    let text = "abc"
    for combination in permutations text:
      echo combination
    
    Ouput:
    
    abc
    bac
    acb
    bca
    cba
    cab
    
Check for an anagram:

    let 
      word = "apple"
      scrambled = "eppal"
    if isAnagram(word, scrambled):
      echo "It's a match."
      
    Output:
    
    It's a match.

Remove vowels from some text:

    let text = "Masterkraft & Subtrakt are great!"
    let txt = removeVowels(text)
    
    Output:
    
    Mstrkrft & Sbtrkt r grt!

