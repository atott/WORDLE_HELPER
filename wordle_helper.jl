

### Read in Common 5 letter Words ###
words = readlines("./data/words.txt")
words = uppercase.(words)

### Take input for a word ##########
function take_word_input()
	println("Please enter 5 letter word")
	word = readline()
	if length(word) != 5
		println("Word must be 5 letters")
		word = take_word_input()
	end
	if all(isletter, word) == false
		println("Must be a english word")
		word = take_word_input()
	end
	word = uppercase(word)
return(word)
end


### Take Color Input #############
function take_color_input()
	println("Please enter color of letter")
	color = readline()
	if length(color) != 5
		println("Color must be 5 characters long")
		color = take_color_input()
	end
	if all(i-> i ∈ ["G","Y","?"], split(color,"")) == false
		println("Must have G,Y or ? in color")
		color = take_color_input()
	end
return(color)
end


### Solve ####
function solve(word::String, color::String, words::Vector{String})
        m = [i for i in word[findall(i -> i == 'Y', color)] ]
        ws = words[vcat(([findall(contains(i), words) for i in m])...)]

        n = [i for i in word[findall(i -> i == '?', color)] ]
        ws = ws[setdiff(1:length(ws), vcat(([findall(contains(i), ws) for i in n])...))]

        for (i,j) in enumerate(color)
           if j == 'G'
               ws = ws[findall(t -> t[i] == word[i], ws)]
           end
        end

        return(ws)
end


counter = 0
while counter < 5 
	global counter = counter
	global words = words
	ws = solve(take_word_input(), take_color_input(), words)
	words = filter!(i -> i ∈ words, ws)
	counter += 1
	
	@show(words)

	if length(words) == 1 
		println(words[1])
		break
	end
end
