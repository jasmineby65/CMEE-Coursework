#### Regex in Python ####
""" Examples of using regex for seaching in Python """
import re 

my_string= "a given string"
match = re.search(r'\s', my_string) # searches for any whitespace character in my_string
print(match) # This only shows whether an match is made or not]
match # Same as above
match.group() # Actually sees the match

match = re.search(r'\d', my_string) # searches for any numeric integer
print(match)

MyStr = "an example"
# searches for whitespace alphanumeric characters preceeded or not preceeded by alphanumeric  
match = re.search(r'\w*\s', MyStr) 
# Checking if a match was made or not using 'if'
if match:
    print("Found a match:", match.group())
else:
    print("No match ):")

match = re.search(r'2', "it takes 2 to tango")
match.group()

match = re.search(r'\d', "it takes 2 to tango")
match.group()

# Searches for numeric and anything that follows it for any length
match = re.search(r'\d.*', "it takes 2 to tango")
match.group()

# Searches for any alphanumeric character of length 1 or 3 surrounded by whitespace
match = re.search(r'\s\w{1,3}\s', "once upon a time")
match.group()

# Searches for alphanueric character of any length at the end of a string preceded by a whitespace
match = re.search(r'\s\w*$', "once upon a time")
match.group()

# .group() can be put straight after the .search
# Searches for any length of anything before whitespace followed by a numeric
# followed by any length of anything before another numeric 
re.search(r'\w*\s\d.*\d', "takes 2 grams of H2O").group()

# Searches for anything of any length following alphanumeric before a space
re.search(r'^\w*.*\s', "once upon a time").group()
# Anything preceded by *, + and {} is repeated as many times as possible 
# until hitting the next meta/regularcharacter
# In this case, all three words before "time" not followed by space are searched 

# Only searches until the first result:
# ? should be placed right after *, +, () to stop their action 
re.search(r'^\w*.*?\s', "once upon a time").group()

re.search(r'<.+>', 'This is a <EM>first</EM> test').group()
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

# \ before . finds the literal "."
re.search(r'\d*\.?\d*', "1432.75+60.22i").group()

# Find any A, G, T, C
re.search(r'[AGTC]+', "the sequence ATTCGT").group()

# Find any alphanumeric preceded by a space and capital letter and any alphanumeric followed by that with a space 
re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()

# Finding profile of people (name, email, description)
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group() 


# Different format of email
MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group() # When there is no match, group() will give error
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr)
match.group()


## Grouping regex patterns ##
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr)
match.group()
match.group(0) # without grouping, all the outputs are in a single line

# With grouping by ():
match = re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)",MyStr)
if match:
    print(match.group(0)) # All output
    print(match.group(1)) # First group 
    print(match.group(2)) # Second group
    print(match.group(3)) # Third group 


## Different Regex commands ##
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"

# findall() will return a list of all matches
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr)
for email in emails:
    print(email)
# Whereas, search() will only give the first match 
re.search(r'[\w\.-]+@[\w\.-]+', MyStr).group()

# findall() can also search through all the lines in a file
f = open("../data/TestOaksData.csv","r")
found_oaks = re.findall(r"Q[\w\s].*\s", f.read()) 
# .read() returns the whole text in a file as a single string
found_oaks

# findall() can also be combined with () grouping 
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a.academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a.academic@imperial.ac.uk, Some other stuff thats even more boring"
found_matches = re.findall(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+)", MyStr)
found_matches # Returns a list of tuple instead of list of strings
for item in found_matches:
    print(item)

## Extracting text from webpages ##

import urllib3 # for extracting website text 

conn = urllib3.PoolManager() # opens a connection to start extracting data from somewhere 
# request() sends a request to the website and "GET" specify the data to be in the form of HTTPResponse object 
r = conn.request("GET", "https://www.imperial.ac.uk/silwood-park/academic-staff/")
webpage_html = r.data # read the data in the HTTPResponce 
type(webpage_html) # This data is in the form of byte not strings so needs decoding
My_Data = webpage_html.decode()
print(My_Data)

pattern = r"(Dr|Professor)\s+(\w{3,}\s+\w+)" # "|" means "or" and {3,} specifies the length to be at least 3 
# compile() compiles a regular expression for repeated use  
regex = re.compile(pattern) 
# finditer() is basically the same as findall() but returns a iterator with the match object so it can be iterated e.g. looped
result = []
for match in regex.findall(My_Data): 
    if match not in result:
        result.append(match)

result


## Replacing text ##
New_Data = re.sub(r'\t'," ", My_Data) # replace all tabs with a space
print(New_Data)
