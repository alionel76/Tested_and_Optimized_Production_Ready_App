import 'package:flutter/material.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../../domain/models/item.dart';
import '../controllers/item_controller.dart';

class AddItemScreen extends StatefulWidget {
  final ItemController itemController;

  const AddItemScreen({
    super.key,
    required this.itemController,
  });

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Électronique';

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm(AppLocalizations l10n) {
    if (_formKey.currentState?.validate() ?? false) {
      final newItem = Item(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        imageUrl: 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400',
      );

      widget.itemController.addItem(newItem);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.itemAddedSuccess)),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addItemTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                label: l10n.itemNameLabel,
                textField: true,
                child: TextFormField(
                  key: const Key('item_name_field'),
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.itemNameLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.nameRequired;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: l10n.itemPriceLabel,
                textField: true,
                child: TextFormField(
                  key: const Key('item_price_field'),
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.itemPriceLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.priceRequired;
                    }
                    final price = double.tryParse(value.trim());
                    if (price == null || price <= 0) {
                      return l10n.validPrice;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: const Key('item_category_field'),
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: l10n.itemCategoryLabel,
                ),
                items: const [
                  DropdownMenuItem(value: 'Électronique', child: Text('Électronique')),
                  DropdownMenuItem(value: 'Livres', child: Text('Livres')),
                  DropdownMenuItem(value: 'Accessoires', child: Text('Accessoires')),
                  DropdownMenuItem(value: 'Maison', child: Text('Maison')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              Semantics(
                label: l10n.itemDescriptionLabel,
                textField: true,
                child: TextFormField(
                  key: const Key('item_description_field'),
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.itemDescriptionLabel,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Semantics(
                label: l10n.submit,
                button: true,
                child: ElevatedButton(
                  key: const Key('submit_item_button'),
                  onPressed: () => _submitForm(l10n),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(l10n.submit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
