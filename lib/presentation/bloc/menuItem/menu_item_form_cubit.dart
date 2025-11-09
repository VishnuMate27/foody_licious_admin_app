import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/update_menu_item_usecase.dart';
import '../../../domain/entities/menuItem/menuItem.dart';

class MenuItemFormState {
  final bool isEditMode;
  final List<String> images;
  final List<String> existingImages;
  final List<String> ingredients;
  final bool isLoading;
  final String? error;

  const MenuItemFormState({
    this.isEditMode = false,
    this.images = const [],
    this.existingImages = const [],
    this.ingredients = const [],
    this.isLoading = false,
    this.error,
  });

  // Add getters
  bool get canAddMoreImages => existingImages.length + images.length < 3;
  List<String> get allImages => [...existingImages, ...images];

  MenuItemFormState copyWith({
    bool? isEditMode,
    List<String>? images,
    List<String>? existingImages,
    List<String>? ingredients,
    bool? isLoading,
    String? error,
  }) {
    return MenuItemFormState(
      isEditMode: isEditMode ?? this.isEditMode,
      images: images ?? this.images,
      existingImages: existingImages ?? this.existingImages,
      ingredients: ingredients ?? this.ingredients,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'MenuItemFormState(isEditMode:$isEditMode, images:${images.length}, ingredients:${ingredients.length}, isLoading:$isLoading, error:$error)';
}

class MenuItemFormCubit extends Cubit<MenuItemFormState> {
  final formKey = GlobalKey<FormState>();

  // Controllers are exposed so UI can bind directly
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController availableQuantityController;
  final TextEditingController ingredientController;

  /// Constructor: optionally pass an initial [MenuItem] for edit mode
  MenuItemFormCubit([MenuItem? initial])
    : nameController = TextEditingController(text: initial?.name ?? ''),
      descriptionController = TextEditingController(
        text: initial?.description ?? '',
      ),
      priceController = TextEditingController(
        text: initial?.price != null ? initial!.price.toString() : '',
      ),
      availableQuantityController = TextEditingController(
        text:
            initial?.availableQuantity != null
                ? initial!.availableQuantity.toString()
                : '',
      ),
      ingredientController = TextEditingController(),
      super(
        MenuItemFormState(
          isEditMode: initial != null,
          images: initial?.images ?? [],
          ingredients: initial?.ingredients ?? [],
        ),
      );

  // ---------------------
  // State mutators (required)
  // ---------------------

  // Toggle edit mode
  void toggleEditing() => emit(state.copyWith(isEditMode: !state.isEditMode));

  // Replace image list (useful after picking images or deleting)
  void updateImageList(List<String> newImages) {
    emit(state.copyWith(images: List<String>.from(newImages)));
  }

  // Add a new ingredient (given text)
  void addIngredient(String ingredient) {
    final trimmed = ingredient.trim();
    // if (trimmed.isEmpty) return;
    final updated = List<String>.from(state.ingredients)..add(trimmed);
    emit(state.copyWith(ingredients: updated));
  }

  // Convenience: add ingredient from the ingredientController and clear it
  void addIngredientFromController() {
    final text = ingredientController.text.trim();
    if (text.isEmpty) return;
    addIngredient(text);
    ingredientController.clear();
  }

  // Remove ingredient by exact match
  void removeIngredient(String ingredient) {
    final updated = List<String>.from(state.ingredients)..remove(ingredient);
    emit(state.copyWith(ingredients: updated));
  }

  // Optionally remove by index
  void removeIngredientAt(int index) {
    if (index < 0 || index >= state.ingredients.length) return;
    final updated = List<String>.from(state.ingredients)..removeAt(index);
    emit(state.copyWith(ingredients: updated));
  }

  // Clear all ingredients
  void clearIngredients() {
    emit(state.copyWith(ingredients: []));
  }

  // ---------------------
  // Helpers for UI submission
  // ---------------------

  // Gather a MenuItem entity (or DTO) from controllers + state
  MenuItem buildMenuItem({required String id, required String restaurantId}) {
    return MenuItem(
      id: id,
      restaurantId: restaurantId,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: int.tryParse(priceController.text) ?? 0,
      availableQuantity: int.tryParse(availableQuantityController.text) ?? 0,
      images: List<String>.from(state.images),
      ingredients: List<String>.from(state.ingredients),
    );
  }

  // ---------------------
  // Cleanup
  // ---------------------
  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    availableQuantityController.dispose();
    ingredientController.dispose();
    return super.close();
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  void updateExistingImages(List<String> images) {
    emit(state.copyWith(existingImages: List<String>.from(images)));
  }

  void removeExistingImage(String image) {
    final updated = List<String>.from(state.existingImages)..remove(image);
    emit(state.copyWith(existingImages: updated));
  }

  void addNewImages(List<String> images) {
    if (state.existingImages.length + images.length > 3) {
      emit(
        state.copyWith(
          error: "Maximum 3 images are allowed. Remove existing images first.",
        ),
      );
      return;
    }
    emit(state.copyWith(images: List<String>.from(images)));
  }

  void removeNewImage(String image) {
    final updated = List<String>.from(state.images)..remove(image);
    emit(state.copyWith(images: updated));
  }

  bool get canAddMoreImages =>
      state.existingImages.length + state.images.length < 3;

  List<String> get allImages => [...state.existingImages, ...state.images];

  List<String> get ingredients => state.ingredients;

  void initializeWithMenuItem(MenuItem item) {
    nameController.text = item.name;
    descriptionController.text = item.description ?? '';
    priceController.text = item.price.toString();
    availableQuantityController.text = item.availableQuantity.toString();

    emit(
      state.copyWith(
        isEditMode: false, // Ensure it's false when initializing
        existingImages: item.images ?? [],
        images: [], // Keep new images empty initially
        ingredients: item.ingredients ?? [],
      ),
    );
  }

  bool validateForm() {
    if (!formKey.currentState!.validate()) return false;

    if (state.allImages.isEmpty) {
      emit(state.copyWith(error: 'At least one image is required'));
      return false;
    }

    return true;
  }

  UpdateMenuItemParams buildUpdateMenuItemParams(String itemId) {
    return UpdateMenuItemParams(
      id: itemId,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: int.tryParse(priceController.text) ?? 0,
      availableQuantity: int.tryParse(availableQuantityController.text) ?? 0,
      ingredients: List<String>.from(state.ingredients),
      images: state.allImages,
    );
  }
}
