

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

        if length(m) > 0
                words = words[vcat(([findall(contains(i), words) for i in m])...)]
        end

        for (i,j) in enumerate(color)
                if j == 'Y'
                        words = words[setdiff(1:length(words), findall(t -> t[i] == word[i], words))]
                end
        end

        n = [i for i in word[findall(i -> i == '?', color)] ]

        for (i,j) in enumerate(color)
           if j == 'G'
               word[i] ∈ n ?  deleteat!(n, findall(t -> t==word[i], n)) : println("")
               words = words[findall(t -> t[i] == word[i], words)]
           end
        end

        if length(n) > 0
                words = words[setdiff(1:length(words), vcat(([findall(contains(i), words) for i in n])...))]
        end

        return(words)
end


counter = 0
while counter < 5 
	global counter = counter
	global words = words
	words = solve(take_word_input(), take_color_input(), words)
	counter += 1
	
	@show(words)

	if length(words) == 1 
		println(words[1])
		break
	end
end
