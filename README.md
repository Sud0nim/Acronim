# Acronim
Some simple procs for messing around with words.

These are especially useless for real-life use, but were a fun way to learn more about Nim.

# Examples

Permutations iterator

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
    
isAnagram

    let 
      word = "apple"
      scrambled = "eppal"
    if isAnagram(word, scrambled):
      echo "It's a match."
      
    Output:
    
    It's a match.
