#include <SDL3/SDL_error.h>
#include <SDL3/SDL_events.h>
#include <SDL3/SDL_gpu.h>
#include <SDL3/SDL_init.h>
#include <SDL3/SDL_video.h>

#include <cstdlib>
#include <exception>
#include <iostream>
#include <stdexcept>
#include <string>

namespace gtg {
class SDLException : public std::runtime_error {
 public:
  explicit SDLException(const std::string& message)
      : std::runtime_error(message + ": " + SDL_GetError()) {}
};
class Game {
 public:
  static constexpr int kWidth = 640;
  static constexpr int kHeight = 480;

  Game() {
    if (!SDL_Init(SDL_INIT_VIDEO)) {
      throw SDLException("SDL_Init");
    }
    window_ =
        SDL_CreateWindow("GameTheGame", kWidth, kHeight, SDL_WINDOW_HIDDEN);
    if (window_ == nullptr) {
      throw SDLException("SDL_CreateWindow");
    }
    device_ = SDL_CreateGPUDevice(SDL_GPU_SHADERFORMAT_SPIRV, true, nullptr);
    if (device_ == nullptr) {
      throw SDLException("SDL_CreateGPUDevice");
    }
    std::cout << "GPU device driver: " << SDL_GetGPUDeviceDriver(device_)
              << '\n';
    if (!SDL_ClaimWindowForGPUDevice(device_, window_)) {
      throw SDLException("SDL_ClaimWindowForGPUDevice");
    }
  }

  Game(const Game&) = default;
  auto operator=(const Game&) -> Game& = default;
  Game(Game&&) = default;
  auto operator=(Game&&) -> Game& = default;

  void Run() {
    running_ = true;
    SDL_ShowWindow(window_);
    while (running_) {
      SDL_Event event;
      while (SDL_PollEvent(&event)) {
        if (event.type == SDL_EVENT_QUIT) {
          running_ = false;
        }
      }
    }
  }

  ~Game() {
    SDL_ReleaseWindowFromGPUDevice(device_, window_);
    SDL_DestroyGPUDevice(device_);
    SDL_DestroyWindow(window_);
    SDL_Quit();
  }

 private:
  bool running_ = false;
  SDL_Window* window_ = nullptr;
  SDL_GPUDevice* device_ = nullptr;
};
}  // namespace gtg

auto main() -> int {
  std::cout << "Hello world!\n";
  try {
    gtg::Game game;
    game.Run();
  } catch (const std::exception& exception) {
    std::cerr << "Exception: " << exception.what() << '\n';
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}
