import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";
import Todo from "../todo";

// Componente TodoList que renderiza múltiples Todo
function TodoList({ todos }) {
  return (
    <div>
      {todos.map((todo) => (
        <Todo key={todo.id} todo={todo} />
      ))}
    </div>
  );
}

// Test de integración
describe("TodoList integration tests", () => {
  test("renders a list of todos and checks for their states", () => {
    const todos = [
      { id: 1, title: "Wash Dishes", completed: false },
      { id: 2, title: "Make Dinner", completed: true },
    ];

    // Renderizamos el componente TodoList con la lista de tareas
    render(<TodoList todos={todos} />);

    // Verificamos que los elementos están en el DOM
    const todo1 = screen.getByTestId("todo-1");
    const todo2 = screen.getByTestId("todo-2");

    expect(todo1).toBeInTheDocument();
    expect(todo2).toBeInTheDocument();

    // Verificamos el contenido de las tareas según su estado
    expect(todo1).toHaveTextContent("Wash Dishes");
    expect(todo1).not.toContainHTML("strike");
    expect(todo2).toHaveTextContent("Make Dinner");
    expect(todo2).toContainHTML("strike");
  });
});
