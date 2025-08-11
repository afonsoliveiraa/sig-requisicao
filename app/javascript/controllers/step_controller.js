import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "step1",
    "step2",
    "step3",
    "bullet1",
    "bullet2",
    "bullet3",
    "label1",
    "label2",
    "label3",
    "confirmModal"
  ];

  connect() {
    const status = this.data.get("status");
    if (status === "CONFIRMADO") {
      this.showStep(3);
    } else {
      this.showStep(1);
    }
  }

  showStep(stepNumber) {
    // Hide all steps first
    this.step1Target.classList.add("hidden");
    this.step2Target.classList.add("hidden");
    this.step3Target.classList.add("hidden");

    // Reset all bullets and labels to inactive
    [this.bullet1Target, this.bullet2Target, this.bullet3Target].forEach(bullet => {
      bullet.classList.remove("bg-blue-600", "text-white");
      bullet.classList.add("bg-gray-200", "text-gray-500");
    });
    [this.label2Target, this.label3Target].forEach(label => {
      label.classList.remove("text-blue-600");
      label.classList.add("text-gray-500");
    });

    // Show current step and update bullets/labels accordingly
    if (stepNumber === 1) {
      this.step1Target.classList.remove("hidden");

      this.bullet1Target.classList.remove("bg-blue-600", "text-white");
      this.bullet1Target.classList.add("bg-gray-200", "text-gray-500");

      this.bullet1Target.classList.remove("bg-gray-200", "text-gray-500");
      this.bullet1Target.classList.add("bg-blue-600", "text-white");

      this.label1Target.classList.remove("text-gray-200");
      this.label1Target.classList.add("text-blue-600")

    } else if (stepNumber === 2) {
      this.step2Target.classList.remove("hidden");

        this.bullet2Target.classList.remove("bg-blue-600", "text-white");
      this.bullet2Target.classList.add("bg-gray-200", "text-gray-500");

      this.bullet2Target.classList.remove("bg-gray-200", "text-gray-500");
      this.bullet2Target.classList.add("bg-blue-600", "text-white");

      this.label2Target.classList.remove("text-gray-500");
      this.label2Target.classList.add("text-blue-600")

    } else if (stepNumber === 3) {
      this.step3Target.classList.remove("hidden");

        this.bullet3Target.classList.remove("bg-blue-600", "text-white");
      this.bullet3Target.classList.add("bg-gray-200", "text-gray-500");

      this.bullet3Target.classList.remove("bg-gray-200", "text-gray-500");
      this.bullet3Target.classList.add("bg-blue-600", "text-white");

      this.label3Target.classList.remove("text-gray-500");
      this.label3Target.classList.add("text-blue-600")
    }

    // Scroll smoothly to the form container
    this.element.querySelector(".w-full.max-w-xl, .w-full.max-w-lg").scrollIntoView({ behavior: "smooth", block: "center" });
  }

  next() {
    // Move from step 1 to 2, or from 2 to 3
    if (!this.step2Target.classList.contains("hidden")) {
      this.showStep(3);
    } else {
      this.showStep(2);
    }
  }

  back() {
    // Move back from step 3 to 2, or from 2 to 1
    if (!this.step3Target.classList.contains("hidden")) {
      this.showStep(2);
    } else {
      this.showStep(1);
    }
  }

  confirmSign(event) {
    event.preventDefault();
    document.getElementById('signature-form').submit();
  }
}
