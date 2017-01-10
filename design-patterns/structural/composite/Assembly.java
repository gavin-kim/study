package structural.composite;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Assembly extends Item {

    private List<Item> items;

    public Assembly(String description) {
        super(description, 0);
        items = new ArrayList<>();
    }

    public void addItem(Item item) {
        items.add(item);
    }

    public void removeItem(Item item) {
        items.remove(item);
    }

    public Item[] getItems() {
        return items.toArray(new Item[items.size()]);
    }

    /** Also have to override getCost() to add cost of items in list */
    public int getCost() {
        return items.stream()
            .mapToInt(Item::getCost)
            .reduce(Integer::sum).orElse(-1);
    }
}
