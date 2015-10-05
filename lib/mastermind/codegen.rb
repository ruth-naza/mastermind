module Mastermind
  class CodeGenerator
  # generates secret sequence based on user level choices.
    def code_generator(user_choice)
      secret = %w(r y g b c m)
      abc = level_specs(user_choice)
      character = abc[0]
      color = abc[1]
      computer_code = []

      until computer_code.length >= character
      i = Random.rand(0..color-1)
      computer_code << secret[i]
      end
      user_status(user_choice)

      secret_code = computer_code.join
      guess_status(secret_code)
    end

     def user_status(user_choice)
      if user_choice == :advanced
        Message.new.advanced_msg
      elsif user_choice == :medium
        Message.new.medium_msg
      else
        Message.new.beginner_msg
      end
    end

    def guess_status(computercode)
      start_time = Time.now
      puts computercode
      guess_count = 0
      while guess_count < 12
        user_entry = gets.chomp.downcase
        if user_entry.length == computercode.length
          puts " You have taken #{guess_count + 1} guess(es) out of 12 guesses."
          comparison(computercode, user_entry, start_time)
        elsif user_entry.length > computercode.length
          puts "Invalid Entry, guess is too long"
          puts " You have taken #{guess_count + 1} guess(es) out of 12 guesses."
        else
          puts "Invalid Entry, guess is too short"
          puts " You have taken #{guess_count + 1} guess(es) out of 12 guesses."
        end
        guess_count += 1
        if guess_count >= 12
          puts "You have exceeded your number of entries"
        end
      end 
    end

    def exact_match(computercode, user_entry)
       exact = 0
       cc = computercode.dup
       cc.split("").each_with_index do |element, index|
         if user_entry[index] == element
           cc[index] = "-"
           user_entry[index] = "-"
           exact += 1
         end
       end
       [exact, cc]
     end

   def partial_match(computercode, user_entry)
      partial = 0
      computercode.split("").each do | element |
        if  element != "-"
          if user_entry.include? element
            user_entry.sub!(element, '-')
            partial += 1
          end
        end
      end
      partial
   end

    def comparison(computercode, user_entry, start_time)
      if computercode == user_entry
        puts "Congratulations! It took you #{(Time.now - start_time).to_i} seconds to complete this game "
      else
        exact_status = exact_match(computercode, user_entry)
        cc = exact_status[1]
        exact_status = exact_status[0]
        partial_status = partial_match(cc, user_entry)
        puts "You have #{exact_status} exact matches and #{partial_status} partial matches"
        puts "Try again!"
      end
    end


    def level_specs(level)
      levels = Hash.new ()
      levels[:advanced] = [8,6]
      levels[:beginner] = [4,4]
      levels[:medium] = [6,5]
      levels[level]
    end
  end
end