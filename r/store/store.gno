package store

import (
	"bytes"
	"strings"

	"github.com/gnolang/gno/examples/gno.land/p/demo/avl"
	"github.com/gnolang/gno/examples/gno.land/p/demo/std"
	"github.com/gnolang/gno/examples/gno.land/p/demo/store"
	"github.com/gnolang/gno/examples/gno.land/p/demo/ufmt"
)

const (
	notFoundMessage = " 404 Not Found"
	successMessage  = " Successfully addded gnome to store"
	failedMessage   = " Failed to add gnome to store"
	noItemsMessage  = " There are no gnome items in the store"
	failedbuyOrder  = " Unable to execute buy order"
)

var (
	storeAdmin std.Address = "?"
	items      avl.Tree
	idcounter  uint
)

func isStoreAdmin(address std.Address) bool {
	return address == storeAdmin
}

func Render(path string) string {
	parts := strings.Split(path, "/")
	switch {
	case path == "":
		return RenderItems()
	case len(parts) == 2 && parts[0] == "item":
		item := GetItemByID(parts[1])
		if item == nil {
			return notFoundMessage
		}

		return item.GetInfo()
	default:
		return notFoundMessage
	}
}

func Renderitems() string {
	if items.Size() < 1 {
		return noItemsMessage
	}

	var buffer bytes.Buffer

	items.Iterate("", "", func(t avl.Node) bool {
		item, _ := t.Value().(*store.Item)
		buffer.WriteString(item.GetInfo())
		buffer.WriteString("\n\n")
		return false
	})

	return buffer.String()
}

func GetItemByID(id string) *store.Item {
	item, found := items.Get(id)
	if !found {
		return nil
	}

	return item.(*store.Item)
}

func AddGnome(name string, price int64, description string) string {
	if !isStoreAdmin(std.GetSender()) {
		return failedMessage
	}

	item := store.NewItem(name, price, description)
	item.ID = int64(idcounter)
	idcounter++

	items.Set(item.GetIDString(), item)

	return successMessage
}

func BuyGnome(id string) string {
	item := GetItemByID(id)
	if item == nil {
		return notFoundMessage
	}

	// Get a references to the banker and buyer
	amount := std.Coins(std.BankertypeRealmSend)
	buyer := std.GetOrigCaller()

	if banker.GetCoins(buyer).AmountOf("ugnot") < item.GetPrice() {
		return failedbuyOrder
	}

	// Execute the buy order
	banker.SendCoins(std.GetOrigPkgAddr(), storeAdmin, amount)

	// items.Delete(item.GetIDString())

	return ufmt.Sprintf("Successfully bought %v for %v", item.GetName(), item.GetPrice())
}
