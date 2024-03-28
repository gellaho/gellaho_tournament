// import * as React from "react";
// import TopbarLinks from "./topbar/TopbarLinks";

// export type HomeProps = {

// }

// export default function Home(props: HomeProps) {
//   return <nav 
//   className="
//     h-12
//     border-emerald-600
//     border-b-2
//     bg-slate-700
//     text-white
//     w-full
//     w-min-full
//     shadow-md
//   "
// >
//   <div className="flex flex-row gap-3 items-center p-2">
//     <%= button_tag(type: "button", class: "flex md:hidden", "x-on:click" => "mobileNav = !mobileNav") do %>
//       <%= icon(:bars_3) %>
//     <% end %>
//     <%= vite_image_tag('images/favicons/profile.png', class: 'h-8') %>
//     <%= link_to('gellaho', root_path, class: "text-emerald-600 font-medium font-moms-typewriter") %>

//     <div className="hidden md:flex flex-row gap-2 items-center">
//       <TopbarLinks />
//     </div>
//   </div>
//   <div
//     className="
//       flex
//       md:hidden
//       flex-col
//       p-2
//       gap-2
//       text-white
//       bg-slate-700
//       z-50
//       relative
//     "
//     x-show="mobileNav"
//   >
//     <TopbarLinks />
//   </div>
// </nav>

// }