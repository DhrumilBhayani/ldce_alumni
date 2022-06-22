package com.example.ld_alumni

import android.content.Context
import com.bumptech.glide.GlideBuilder
import com.bumptech.glide.annotation.GlideModule
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.module.AppGlideModule
import com.bumptech.glide.request.RequestOptions
import com.bumptech.glide.signature.ObjectKey
 
@GlideModule
class LdceGlideModule : AppGlideModule() {
    override fun applyOptions(context: Context, builder: GlideBuilder) {
        super.applyOptions(context, builder)
        val requestOptions = RequestOptions().diskCacheStrategy(DiskCacheStrategy.ALL)
            .signature(
                ObjectKey(
                    System.currentTimeMillis() / (24 * 60 * 60 * 1000)
                )
            )
        builder.setDefaultRequestOptions(requestOptions)
    }
}