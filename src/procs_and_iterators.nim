
import algorithm, future, strutils, unicode, tables, parsecsv

iterator permutations*(text: string): string =
  # Adapted from https://bitbucket.org/nimcontrib/nimcombinatorics/src/4b61d417e9ad4386caf3791f1999fd9889193e01/combinatorics.nim?at=default&fileviewer=file-view-default
  # Credit/licence at end of file
  # Iterates through all possible combinations of the letters in text
  let n = len(text)
  var position = newSeq[int](n)
  var newPermutation = newString(n)
  for i in 0..<n:
    position[i] = i
  while true:
    for i in 0..<n:
      newPermutation[i] = newPermutation[position[i]]
      newPermutation[position[i]] = text[i]
    yield newPermutation
    var i = 1
    while i < n:
      position[i] -= 1
      if position[i] < 0:
        position[i] = i
        i += 1
      else:
        break
    if i >= n:
      break

proc isAnagram*(word, scrambledWord: string): bool =
  # Returns true if scrabledWord is an anagram of word
  if len(scrambledWord) == len(word):
    var 
      wordCharacters = lc[toLowerAscii(x) | (x <- word), char] 
      scrambledCharacters = lc[toLowerAscii(x) | (x <- scrambledWord), char]  
    sort(wordCharacters, system.cmp[char])
    sort(scrambledCharacters, system.cmp[char])
    if wordCharacters == scrambledCharacters:
      return true
  return false

iterator stepBy*(text: string; stepSize: int, startPoint: int = 0, endPoint: int = text.high): string =
  # Step through letters with a given interval, start and end point
  var 
    endPosition = text.high
    startPosition = 0
  if endPoint <= text.high and endPoint >= 0:
      endPosition = endPoint
  if startPoint <= text.high and startPoint >= 0:
      startPosition = startPoint
  var
    characters = lc[x | (x <- text), char]
    stepped = ""
    lastPosition = stepSize * -1 + startPosition
  for i in startPosition..endPosition:
    if i == lastPosition + stepSize:
      lastPosition += stepSize
      stepped &= characters[i]
  yield stepped

proc removeVowels*(text: string): string =
  # In case you are a musician like MGMT or SBTRKT and really hate vowels...
  result = split(toLowerAscii(text), {'a','e','i', 'o', 'u'}).join("")

proc countVowels*(text: string): int =
  # Just to make sure none of those pesky vowels sneak in to your stage name
  result = 0
  for i in text:
    if i in ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']:
      inc result

proc countConsonants*(text: string): int =
  result = len(text)
  result -= countVowels(text)

proc mostCommonLetter*(text: string): tuple =
  var counts = initCountTable[char]()
  for letter in text:
    if letter in Letters:
      if counts.contains(toLowerAscii(letter)):
        inc counts[toLowerAscii(letter)]
      else:
        counts[toLowerAscii(letter)] = 1
  result = largest(counts)

proc isPallindrome*(text: string): bool =
  if toLowerAscii(text) == toLowerAscii(reversed(text)):
    return true
  else:
    return false

proc isPangram*(text: string): bool =
  # Returns true if the text contains every letter in the English alphabet (a pangram)
  let pangram = toLowerAscii(text)
  var count = 0
  for letter in 'a'..'z':
      if letter in pangram:
        inc count
  if count == 26:
      return true
  else:
      return false

proc makeAcronym*(text: string): string =
  # Makes an acronym from a string containing whitespace separated words
  var words = split(text)
  result = ""
  for word in words:
    result &= word[0]
  result = result.toUpperAscii

# Scrabble Solver Procs:

proc letterValue*(letter: char): int =
  # Returns the value of the given letter according the official Scrabble rules
  let character = toLowerAscii(letter)
  case character:
  of 'q', 'z':
    return 10
  of 'j', 'x':
    return 8
  of 'k':
    return 5
  of 'f', 'h', 'v', 'w', 'y':
    return 4
  of 'b', 'c', 'm', 'p':
    return 3
  of 'd', 'g':
    return 2
  else:
    return 1

proc wordValue*(word: string): int =
  # Returns the Scrabble value of a given word
  result = 0
  for i in word:
    result += letterValue(i)
 
proc isIn*(word, letters: string): bool =
  # Returns true if 'word' can be made out of 'letters' using each letter only once
  var 
    wordLetters = toLowerAscii(word)
    scrambledLetters = toLowerAscii(letters)
    wordLetterCounts = initCountTable[char]()
    scrambledLetterCounts = initCountTable[char]()
    letterCount = 0
  for i in wordLetters:
    if wordLetterCounts.contains(i):
      inc wordLetterCounts[i]
    else:
      wordLetterCounts[i] = 1
  for j in scrambledLetters:
    if scrambledLetterCounts.contains(j):
      inc scrambledLetterCounts[j]
    else:
      scrambledLetterCounts[j] = 1
  for k, v in wordLetterCounts:
    if scrambledLetterCounts.contains(k) and scrambledLetterCounts[k] >= wordLetterCounts[k]:
      inc letterCount
  if letterCount == len(wordLetterCounts):
    return true
  else:
    return false

proc printWordScores*(filename: string) =
  # Returns the possible word scores and combinations from user provided letters
  var
    parser: CsvParser
    letters = toLowerAscii(readline(stdin))
    bestScore = 0
    bestWord: string
  parser.open(filename)
  parser.readHeaderRow() 
  while parser.readRow():
    for col in items(parser.headers):
      var
        dictEntry = parser.rowEntry(col)
      if len(dictEntry) <= len(letters):
        if dictEntry.isIn(letters):
          var newScore = wordValue(dictEntry)
          echo("New Word: ", dictEntry, " Score: ", newScore)
          if newScore > bestScore:
            bestScore = newScore
            bestWord = dictEntry
  echo("Best Word: ", bestWord, " Score: ", bestScore)
  parser.close()

# Procs used in challenge 319 of r/DailyProgrammer:

proc joinedTo*(a,b: string): string =
  # Checks if two strings can be merged on common letters at the end of 'a' and start of 'b'
  for i in 0..a.high:
    for j in countdown(b.high, 0):
      if a[i..a.high] == b[0..j]:
        result = b[j + 1..b.high]


proc recombobulate*(input: string): string =
  # Takes a sentence string and returns a condensed version where any 'joinable' words are merged together
  var sentence = input.split()
  for n in 0..sentence.high:
    if n == 0:
      result = sentence[n]
    elif result.joinedTo(sentence[n]) != nil:
      result &= result.joinedTo(sentence[n])
    else:
      result &= " " & sentence[n]

proc transposeText*(filename: string) =
  # Transposes text from a .txt file and prints the transposed text to the console
  var
    maxLength = 0
    lines = newSeq[string](0)
    paddedLines = newSeq[string](0)
    text = open(filename)
    emptyLine = ""
  while endOfFile(text) != true:
    lines.add(readline(text))
  close(text)
  for line in lines:
    if len(line) > maxLength:
      maxLength = len(line)
  for i in 0..<maxLength:
    emptyLine &= " "
  for line in lines:
    var newLine = emptyLine
    for i in line.low..line.high:
      newLine[i] = line[i]
    paddedLines.add(newLine)
  for i in 0..<maxLength:  
    for line in paddedLines:
      stdout.write line[i]
    echo ""


# Credit for permutations iterator:

#[Copyright (c) 2014 Reimer Behrends

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.]#
