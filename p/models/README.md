# Gno.Lair Common Models

Includes common models, interfaces, and other classes that can be used by any project.

## Models

### `IModel`

The `IModel` interface is the base interface for all models. It defines the `id` property, which is the unique identifier for the model.

### `Model`

The `Model` class is the base class for all models. It implements the `IModel` interface and defines the `id` property.

### `IUser`

The `IUser` interface is the base interface for all user models. It extends the `IModel` interface and defines the `username` property, which is the unique username for the user.


### Testing
    
```bash
gno test --root-dir ~/go/src/github.com/gno/ ./
```