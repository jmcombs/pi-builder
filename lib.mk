# ========================================================================== #
#                                                                            #
#    pi-builder - extensible tool to build Arch Linux ARM for Raspberry Pi   #
#                 on x86_64 host using Docker.                               #
#                                                                            #
#    Copyright (C) 2018-2023  Maxim Devaev <mdevaev@gmail.com>               #
#                                                                            #
#    This program is free software: you can redistribute it and/or modify    #
#    it under the terms of the GNU General Public License as published by    #
#    the Free Software Foundation, either version 3 of the License, or       #
#    (at your option) any later version.                                     #
#                                                                            #
#    This program is distributed in the hope that it will be useful,         #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of          #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           #
#    GNU General Public License for more details.                            #
#                                                                            #
#    You should have received a copy of the GNU General Public License       #
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.  #
#                                                                            #
# ========================================================================== #

# optbool function: Converts the input to lowercase and checks if it is 'yes', 'on', or '1'.
# If it is, the function returns the input; otherwise, it returns nothing.
define optbool
$(filter $(shell echo $(1) | tr A-Z a-z),yes on 1)
endef

# say function: Prints the input in bold green text.
define say
@ tput -Txterm bold
@ tput -Txterm setaf 2
@ echo "===== $1 ====="
@ tput -Txterm sgr0
endef

# die function: Prints the input in bold red text and then exits with a status of 1.
define die
@ tput -Txterm bold
@ tput -Txterm setaf 1
@ echo "===== $1 ====="
@ tput -Txterm sgr0
@ exit 1
endef

# notempty function: Checks if the variable named in the input is empty.
# If it is, the function throws an error.
define notempty
$(eval $(if $($(1)),,$(error $(1) is empty)))
endef

# append function: Iterates over the third argument, prepends the first argument and appends the second argument to each item.
define append
$(foreach _item,$(3),$(1)$(_item)$(2))
endef

# contains function: Checks if the first argument is a substring of the second argument.
# If it is, the function returns the third argument; otherwise, it returns the fourth argument.
define contains
$(if $(findstring $(1),$(2)),$(3),$(4))
endef

# cachetag function: Checks if the first argument is not empty and then writes a predefined signature to a file named "CACHEDIR.TAG" in the directory specified by the first argument.
define cachetag
test -n "$1"
echo "Signature: 8a477f597d28d172789f06886806bc55" > "$1/CACHEDIR.TAG"
endef
