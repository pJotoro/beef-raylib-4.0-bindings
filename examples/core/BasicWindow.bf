using Raylib;

namespace BeefRaylibBindingsTest
{
	class Program
	{
		public static void Main()
		{
			const int32 SCREEN_WIDTH = 800;
			const int32 SCREEN_HEIGHT = 450;

			InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - basic window");

			SetTargetFPS(60);

			while (!WindowShouldClose())
			{
				BeginDrawing();

					ClearBackground(RAYWHITE);

					DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

				EndDrawing();
			}

			CloseWindow();
		}
	}
}