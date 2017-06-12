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

Check if a word is a pallindrome:

    let word = "racecar"
    if word.isPallindrome:
      echo word
    
    Output:
    
    racecar

Make sure a word uses all letters in the alphabet (a pangram):

    let sentence = "Sphinx of black quartz, judge my vow"
    if sentence.isPangram:
      echo "This one has everything from A to Z."
      
    Output:
    
    This one has everything from A to Z.
    
Turn a sentence in to an acronym:

    let sentence = "Sphinx of black quartz, judge my vow"
    echo makeAcronym(sentence)
    
    Output:
    
    Sobqjmv
    
Find the most frequently used letter in some text:

    let words = "All the kings men couldn't put Humpty back together again."
    echo "Letter '", words.mostCommonLetter.key,"' came up ", words.mostCommonLetter.val, " times."
    
    Output:
    
    Letter 't' came up 6 times.
