# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jbobin <jbobin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/03/02 14:13:18 by jbobin            #+#    #+#              #
#    Updated: 2017/11/06 08:59:38 by jbobin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = ibft_malloc_$HOSTTYPE.so

SRC_DIR = src

OBJ_DIR = obj

INC_DIR = inc

SRC =

SRC_O = $(SRC:.c=.o)

DSRC = $(addprefix $(SRC_DIR)/,$(SRC))

DOBJ = $(addprefix $(OBJ_DIR)/,$(SRC_O))

FLAGS = -Wall -Wextra -Werror -g

HEADERS = -I ./$(INC_DIR) -I libft/includes/ -I completion

ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif

all: $(NAME)

$(NAME):
	make -C libft/
	mkdir -p $(OBJ_DIR)
	gcc $(FLAGS) -I./libft -I./$(INC_DIR) -c $(DSRC)
	mv $(SRC_O) $(OBJ_DIR)
	gcc $(FLAGS) libft/libft.a -I./$(INC_DIR) -L./libft -lft -ltermcap -o $(NAME) $(DOBJ)

clean:
	make -C libft/ clean
	rm -rf $(OBJ_DIR)

fclean: clean
	make -C libft/ fclean
	rm -f $(NAME)

re: fclean all

.PHONY: all, $(NAME), clean, fclean, re
