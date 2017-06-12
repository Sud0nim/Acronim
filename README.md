# Acronim
Some simple procs for messing around with words.

These are especially useless for real-life use, but were a fun way to learn more about Nim.

# Examples

Iterate through all possible combinations of the letters in a word:

    let text = "abc"
    for combination in text.permutations:
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
    if word.isAnagram(scrambled):
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
    
    SOBQJMV
    
Find the most frequently used letter in some text:

    let words = "All the kings men couldn't put Humpty back together again."
    echo "Letter '", words.mostCommonLetter.key,"' came up ", words.mostCommonLetter.val, " times."
    
    Output:
    
    Letter 't' came up 6 times.

Count the vowels and consonants in text:

    let words = "All the kings men couldn't put Humpty back together again."
    echo words.countConsonants," consonants and ", words.countVowels, " vowels."
    
    Output:
    
    43 consonants and 15 vowels.

Iterate through every 2nd letter:

    let words = "Pack my box with five dozen liquor jugs"
    for letter in words.stepBy(2):
      echo letter
      
    Output:
    
    Pc ybxwt iedznlqo us

Iterate through every 2nd letter, starting at the 4th (index: 3) letter and ending at the 16th (index: 15):

    let words = "Pack my box with five dozen liquor jugs"
    for letter in words.stepBy(2, 3, 15):
      echo letter
      
    Output:
    
    km o ih

