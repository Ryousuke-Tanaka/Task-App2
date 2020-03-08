# coding: utf-8

User.create!( name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password")

User.create!( name: "ゲスト管理者",
              email: "guest-admin@email.com",
              password: "password",
              password_confirmation: "password")

User.create!( name: "ゲストユーザー",
              email: "guest@email.com",
              password: "password",
              password_confirmation: "password")