# HI :3

## Table of contents
- this should get auto generated

## Deleting
I was overthinking it for a long long time and it will propaply be changed again and again and again (god i am tired)

anyway

here is how it works 

**Board View:**
- when you delete a symbols they are moved to trash
- when you delete a symbol that links to a board we only move this symbol to the trash and inform the user about it in a popup

**Symbol Search view:**
Same as Board View

**Board Search view**
- here we can actually delete a board but we only perform shallow delete. Imagine there's Board A that has a symbol B that links to some Board C. Deleting A will delete B but leave C untouched. And that's because I didn't want to deal with circular dependecies because they would be hella confusing for end user
- when deleting a board we also remove all links to this board
