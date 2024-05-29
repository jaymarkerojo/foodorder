import javax.swing.*;
import java.awt.*;

public class FoodOrderingSystemGUI extends JFrame {
    // Attributes
    String[] mainMenu = {"Burgers", "Fries & Extras", "Drinks & Dessert", "Group Meals", "Chicken Nuggets", "Chickenjoy", "Chicken Sandwich"};
    String[][] subMenu = {
        {"McCrispy Chicken Sandwich w/ fries", "Burger McDo w/Fries", "Burger McDo Solo"},
        {"BFF Fries", "McShaker Medium Fries", "McShaker Large Fries"},
        {"Hot Fudge Sundae", "Hot Caramel Sundae", "McCafe Iced Coffee", "Coke Original Taste"},
        {"6-pc Chicken McShare Box", "8-pc Chicken McShare Box", "BFF Fries N'3 McFloat Combo"},
        {"6-pc Chicken Nuggets", "6-pc Chicken Nuggets w/Fries and Drinks", "10-pc Chicken Nuggets"},
        {"1-pc Chickenjoy Solo", "1-pc Chickenjoy w/Drink", "2-pc Chickenjoy Solo", "1-pc Chickenjoy w/Fries And Drinks"},
        {"Crunchy Chicken Sandwich", "Crunchy Chicken Sandwich w/Drink", "Chicken Sandwich Supreme"}
    };
    double[][] prices = {
        {185.75, 168, 44.00},
        {169, 98.50, 120},
        {55, 55, 61, 75},
        {495.75, 651.75, 282},
        {114.00, 183.00, 202.00},
        {91.00, 114.00, 180.00, 170.00},
        {65.00, 103.00, 164.00}
    };
    DefaultListModel<String> orderListModel = new DefaultListModel<>();
    DefaultListModel<Double> orderPriceListModel = new DefaultListModel<>();
    DefaultListModel<Integer> orderQuantityListModel = new DefaultListModel<>();

    // Constructor
    public FoodOrderingSystemGUI() {
        setTitle("McDonald's Food Ordering System");
        setSize(800, 600);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Set McDonald's style colors
        Color mcdoRed = new Color(224, 30, 36);
        Color mcdoYellow = new Color(255, 199, 44);
        Color mcdoWhite = Color.WHITE;

        // Title Panel
        JPanel titlePanel = new JPanel();
        titlePanel.setBackground(mcdoRed);
        JLabel titleLabel = new JLabel("Welcome to McDonald's!");
        titleLabel.setForeground(mcdoWhite);
        titleLabel.setFont(new Font("Arial", Font.BOLD, 24));
        titlePanel.add(titleLabel);

        // Menu Panel
        JPanel menuPanel = new JPanel(new BorderLayout());
        menuPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        JComboBox<String> mainMenuComboBox = new JComboBox<>(mainMenu);
        mainMenuComboBox.setBackground(mcdoYellow);
        mainMenuComboBox.setForeground(mcdoRed);
        mainMenuComboBox.setFont(new Font("Arial", Font.BOLD, 14));
        JList<String> subMenuList = new JList<>();
        JTextArea itemDetails = new JTextArea();
        itemDetails.setEditable(false);
        itemDetails.setBackground(mcdoWhite);
        itemDetails.setFont(new Font("Arial", Font.PLAIN, 14));

        mainMenuComboBox.addActionListener(e -> {
            int selectedIndex = mainMenuComboBox.getSelectedIndex();
            DefaultListModel<String> subMenuModel = new DefaultListModel<>();
            for (String item : subMenu[selectedIndex]) {
                subMenuModel.addElement(item);
            }
            subMenuList.setModel(subMenuModel);
        });

        subMenuList.addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting()) {
                int selectedIndex = subMenuList.getSelectedIndex();
                if (selectedIndex != -1) {
                    int mainIndex = mainMenuComboBox.getSelectedIndex();
                    itemDetails.setText(subMenu[mainIndex][selectedIndex] + "\nPrice: P" + prices[mainIndex][selectedIndex]);
                }
            }
        });

        menuPanel.add(mainMenuComboBox, BorderLayout.NORTH);
        menuPanel.add(new JScrollPane(subMenuList), BorderLayout.CENTER);
        menuPanel.add(itemDetails, BorderLayout.SOUTH);

        // Order Panel
        JPanel orderPanel = new JPanel(new BorderLayout());
        orderPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        orderPanel.setBackground(mcdoWhite);
        JList<String> orderList = new JList<>(orderListModel);
        orderList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        JTextArea orderDetails = new JTextArea();
        orderDetails.setEditable(false);
        orderDetails.setBackground(mcdoWhite);
        orderDetails.setFont(new Font("Arial", Font.PLAIN, 14));
        JButton removeButton = new JButton("Remove Item");
        removeButton.setBackground(mcdoRed);
        removeButton.setForeground(mcdoWhite);
        removeButton.setFont(new Font("Arial", Font.BOLD, 14));

        removeButton.addActionListener(e -> {
            int selectedIndex = orderList.getSelectedIndex();
            if (selectedIndex != -1) {
                orderListModel.remove(selectedIndex);
                orderPriceListModel.remove(selectedIndex);
                orderQuantityListModel.remove(selectedIndex);
                updateOrderDetails(orderDetails);
            }
        });

        orderPanel.add(new JScrollPane(orderList), BorderLayout.CENTER);
        orderPanel.add(removeButton, BorderLayout.SOUTH);
        orderPanel.add(orderDetails, BorderLayout.NORTH);

        // Control Panel
        JPanel controlPanel = new JPanel(new GridLayout(6, 2, 5, 5));
        controlPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        controlPanel.setBackground(mcdoWhite);
        JTextField quantityField = new JTextField();
        JTextField nameField = new JTextField();
        JTextField addressField = new JTextField();
        JTextField phoneField = new JTextField();
        JTextField notesField = new JTextField();
        JComboBox<String> deliveryPickupComboBox = new JComboBox<>(new String[]{"Delivery", "Pickup"});

        controlPanel.add(new JLabel("Quantity:"));
        controlPanel.add(quantityField);
        controlPanel.add(new JLabel("Name:"));
        controlPanel.add(nameField);
        controlPanel.add(new JLabel("Address:"));
        controlPanel.add(addressField);
        controlPanel.add(new JLabel("Phone:"));
        controlPanel.add(phoneField);
        controlPanel.add(new JLabel("Notes:"));
        controlPanel.add(notesField);
        controlPanel.add(new JLabel("Delivery/Pickup:"));
        controlPanel.add(deliveryPickupComboBox);

        // Button Panel
        JPanel buttonPanel = new JPanel();
        buttonPanel.setBackground(mcdoWhite);
        JButton addButton = new JButton("Add to Order");
        addButton.setBackground(mcdoYellow);
        addButton.setForeground(mcdoRed);
        addButton.setFont(new Font("Arial", Font.BOLD, 14));
        JButton checkoutButton = new JButton("Checkout");
        checkoutButton.setBackground(mcdoRed);
        checkoutButton.setForeground(mcdoWhite);
        checkoutButton.setFont(new Font("Arial", Font.BOLD, 14));

        addButton.addActionListener(e -> {
            int mainIndex = mainMenuComboBox.getSelectedIndex();
            int subIndex = subMenuList.getSelectedIndex();
            if (mainIndex != -1 && subIndex != -1 && !quantityField.getText().isEmpty()) {
                int quantity = Integer.parseInt(quantityField.getText());
                orderListModel.addElement(subMenu[mainIndex][subIndex] + " (x" + quantity + ")");
                orderPriceListModel.addElement(prices[mainIndex][subIndex] * quantity);
                orderQuantityListModel.addElement(quantity);
                updateOrderDetails(orderDetails);
            }
        });

        checkoutButton.addActionListener(e -> {
            String deliveryOption = (String) deliveryPickupComboBox.getSelectedItem();
            String name = nameField.getText();
            String address = addressField.getText();
            String phone = phoneField.getText();
            String notes = notesField.getText();

            StringBuilder receipt = new StringBuilder();
            receipt.append("Receipt:\n");
            receipt.append("Delivery Option: ").append(deliveryOption).append("\n");
            if (deliveryOption.equals("Delivery")) {
                receipt.append("Name: ").append(name).append("\n");
                receipt.append("Address: ").append(address).append("\n");
                receipt.append("Phone: ").append(phone).append("\n");
                receipt.append("Notes: ").append(notes).append("\n");
            }
            double total = 0;
            for (int i = 0; i < orderListModel.size(); i++) {
                receipt.append(orderListModel.get(i)).append(" - P").append(orderPriceListModel.get(i)).append("\n");
                total += orderPriceListModel.get(i);
            }
            receipt.append("Total: P").append(total);

            JOptionPane.showMessageDialog(this, receipt.toString(), "Receipt", JOptionPane.INFORMATION_MESSAGE);
        });

        buttonPanel.add(addButton);
        buttonPanel.add(checkoutButton);

        add(titlePanel, BorderLayout.NORTH);
        add(menuPanel, BorderLayout.WEST);
        add(orderPanel, BorderLayout.EAST);
        add(controlPanel, BorderLayout.CENTER);
        add(buttonPanel, BorderLayout.SOUTH);
    }

    private void updateOrderDetails(JTextArea orderDetails) {
        StringBuilder details = new StringBuilder();
        double total = 0;
        for (int i = 0; i < orderListModel.size(); i++) {
            details.append(orderListModel.get(i)).append(" - P").append(orderPriceListModel.get(i)).append("\n");
            total += orderPriceListModel.get(i);
        }
        details.append("Total: P").append(total);
        orderDetails.setText(details.toString());
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new FoodOrderingSystemGUI().setVisible(true);
        });
    }
}
