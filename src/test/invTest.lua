InvTest = {}

-- Modules to test
local Item      = require("src.entities.item")
local Inventory = require("src.systems.inventory")


function InvTest.test1()
    item1 = Item("test1", nil, 1)
    item2 = Item("test2", nil, 1)

    -- Adding two items to inventory
    Inventory.addToInventory(item1)
    Inventory.addToInventory(item2)

    print("Check if Items added to Inventory\nExpected: int and true")
    print(Inventory.checkInventory("test1"))

    print("Check if Item 2 added to Inventory\nExpected: int and true")
    print(Inventory.checkInventory("test2"))

    print("Remove Item test1\n, expected result: true")
    print(Inventory.removeItem("test1"))

    print("Check if removed item is in list\nExpected: false")
    print(Inventory.checkInventory("test1"))

end

return InvTest
