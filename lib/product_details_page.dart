import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late String displayedImage;
  late String selectedColorName;
  int quantity = 1;
  late double unitPrice;

  @override
  void initState() {
    super.initState();
    displayedImage = widget.product['image'];
    selectedColorName = widget.product['colors'][0];

    // Parse the price string (e.g., "RM 150.00/box") to a double
    final priceString = widget.product['price'].toString().replaceAll('RM', '').split('/')[0].trim();
    unitPrice = double.tryParse(priceString) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = (unitPrice * quantity).toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                displayedImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Product Name
            Text(widget.product['name'],
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            // Tags
            Wrap(
              spacing: 6,
              children: (widget.product['tags'] as List<String>)
                  .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(tag, style: const TextStyle(fontSize: 12)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),

            // Price per box
            Text(widget.product['price'],
                style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 28)),
            const SizedBox(height: 12),

            // Description box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.shade700,
                  style: BorderStyle.solid, // you can later change to dashed if needed
                ),
              ),
              child: const Text(
                'This is a premium quality flooring product. Durable, eco-friendly, perfect for interiors.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),

            // Color name
            Text('Color: $selectedColorName',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            // Color options (names only)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  (widget.product['colors'] as List).length,
                  (index) {
                    final colorName = widget.product['colors'][index];
                    final isSelected = selectedColorName == colorName;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorName = colorName;
                          displayedImage =
                              widget.product['colorImages'][index];
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.orange.shade200
                              : Colors.grey.shade200,
                          border: Border.all(
                            color: isSelected ? Colors.orange : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            colorName,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.orange.shade900
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Quantity selector
            Row(
              children: [
                const Text("Quantity:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text(quantity.toString(),
                          style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Total Price
            Text("Total: RM $totalPrice",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange)),
            const SizedBox(height: 20),

            // Add to Cart button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Add your cart logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!')),
                  );
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
